include(doc_shared.pri)

DOC_OUTDIR_POSTFIX = /html
DOC_HTML_INSTALLDIR = $$LIRI_INSTALL_DOCDIR/fluid
DOC_QCH_OUTDIR = $$OUT_PWD/doc
DOC_QCH_INSTALLDIR = $$LIRI_INSTALL_DOCDIR/fluid

OTHER_FILES += \
    $$PWD/fluid.qdocconf \
    $$PWD/fluid-online.qdocconf \
    $$PWD/src/fluidcontrols-qmltypes.qdoc \
    $$PWD/src/fluidcore-qmltypes.qdoc \
    $$PWD/src/fluideffects-qmltypes.qdoc \
    $$PWD/src/fluidlayouts-qmltypes.qdoc \
    $$PWD/src/fluidmaterial-qmltypes.qdoc \
    $$PWD/src/index.qdoc

include(doc_targets.pri)
