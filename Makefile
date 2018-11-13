# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = d3-spanish
SOURCEDIR     = source
BUILDDIR      = build

python        = python3

html-show:
	make html
	make show

show:
	if [ ! -d "build/html/" ]; then make html; fi
	see build/html/index.html &

watch:
	make html
	if ! python -c 'import pkgutil; exit(not pkgutil.find_loader("watchgod"))'; then printf ""; else sudo $(python) -m pip install watchgod; fi
	$(python) watch.py

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)