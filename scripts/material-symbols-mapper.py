#!/usr/bin/env python3
"""
Material Design 3 Symbol Mapper

This script generates a JSON mapping file for Material Design 3 symbols.
The mapping file contains symbol names to Unicode character mappings.

Format of the output JSON:
{
    "symbol_name": "unicode_char",
    ...
}

Example:
{
    "10k": "",
    "10mp": "",
    "11mp": "",
    ...
}
"""

import argparse
import json
from pathlib import Path
from typing import Dict
import requests
from io import StringIO


def download_codepoints_file(url: str) -> str:
    """Download the Material Symbols codepoints and return them."""
    response = requests.get(url)
    response.raise_for_status()  # Ensure we notice bad responses
    return response.text


def parse_codepoints_file(file_content: str) -> Dict[str, str]:
    """Parse the Material Symbols codepoints file and return name->unicode mappings."""
    mappings = {}

    file_stream = StringIO(file_content)
    for line in file_stream:
        line = line.strip()
        if not line or line.startswith('#'):
            continue
            
        # Format is: symbol_name codepoint
        parts = line.split(' ')
        if len(parts) != 2:
            continue
            
        name, codepoint = parts
        # Convert codepoint to actual unicode character
        try:
            unicode_char = chr(int(codepoint, 16))
            mappings[name] = unicode_char
        except ValueError:
            print(f"Warning: Invalid codepoint for symbol {name}: {codepoint}")
                
    return mappings


def validate_mappings(mappings: Dict[str, str]) -> bool:
    """Validate the mappings to ensure they're properly formatted."""
    valid = True
    for name, char in mappings.items():
        if not name.replace('_', '').isalnum():
            print(f"Warning: Invalid symbol name: {name}")
            valid = False
        if not char:
            print(f"Warning: Missing unicode character for: {name}")
            valid = False
    return valid


def main():
    parser = argparse.ArgumentParser(description='Generate Material Design 3 symbol mappings')
    parser.add_argument('output_file', type=Path,
                       help='Path to output JSON file')

    args = parser.parse_args()

    # Parse and validate mappings
    codepoints_url = "https://raw.githubusercontent.com/google/material-design-icons/refs/heads/master/font/MaterialIcons-Regular.codepoints"
    mappings = parse_codepoints_file(download_codepoints_file(codepoints_url))
    if not validate_mappings(mappings):
        print("Warning: Some mappings are invalid")
        
    # Write JSON output
    with open(args.output_file, 'w', encoding='utf-8') as f:
        json.dump(mappings, f, ensure_ascii=False, indent=2, sort_keys=True)
        
    print(f"Successfully generated mappings for {len(mappings)} symbols")
    print(f"Output written to: {args.output_file}")
    
    return 0


if __name__ == '__main__':
    exit(main())
