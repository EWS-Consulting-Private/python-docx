BEHAVE = behave
MAKE   = make
PYTHON = .venv/bin/python
SETUP  = $(PYTHON) ./setup.py

.PHONY: accept clean coverage docs readme register sdist test upload

help:
	@echo "Please use \`make <target>' where <target> is one or more of"
	@echo "  accept    run acceptance tests using behave"
	@echo "  clean     delete intermediate work product and start fresh"
	@echo "  cleandocs delete intermediate documentation files"
	@echo "  coverage  run nosetests with coverage"
	@echo "  docs      generate documentation"
	@echo "  opendocs  open browser to local version of documentation"
	@echo "  register  update metadata (README.rst) on PyPI"
	@echo "-------------------- EWS Specific --------------------"
	@echo "  venv      Create the virtual environnement"
	@echo "  deps      Install the PIP dependencies"
	@echo "  build     generate a source distribution into dist/"
	@echo "  upload    upload distribution tarball to PyPI"

venv:
	python3 -m venv .venv --clear 

deps:
	$(PYTHON) -m pip install wheel build twine


accept:
	$(BEHAVE) --stop

clean:
	find . -type f -name \*.pyc -exec rm {} \;
	rm -rf dist *.egg-info .coverage .DS_Store

cleandocs:
	$(MAKE) -C docs clean

coverage:
	py.test --cov-report term-missing --cov=docx tests/

docs:
	$(MAKE) -C docs html

opendocs:
	open docs/.build/html/index.html

build: clean 
	 $(PYTHON) -m build --sdist --wheel --outdir ./dist

upload: 
	 $(PYTHON) -m twine upload --verbose --repository-url http://wks10pro-125:8082/ --username . --password . ./dist/*
