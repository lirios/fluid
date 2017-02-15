fluiddoc_version.name = FLUID_VERSION
fluiddoc_version.value = $$FLUID_VERSION
fluiddoc_versiontag.name = FLUID_VERSION_TAG
fluiddoc_versiontag.value = $$replace(FLUID_VERSION, "[-.]", )
fluiddoc_qtdocs.name = QT_INSTALL_DOCS
fluiddoc_qtdocs.value = $$[QT_INSTALL_DOCS/src]
QDOC_ENV += fluiddoc_version fluiddoc_versiontag fluiddoc_qtdocs

build_online_docs: \
    DOC_FILES += $$PWD/fluid-online.qdocconf
else: \
    DOC_FILES += $$PWD/fluid.qdocconf
