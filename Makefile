.DEFAULT_GOAL := run

VENV?=.venv
ENV_OPTINOS?=--system-site-packages
CONFIG_FILE?=production.ini


ensure-venv:
	@echo '============================= creating virtual environmetn ============================='
	[ -d $(VENV) ] || { python3 -m venv $(ENV_OPTINOS) $(VENV);}


build-initial-dependencies:  ensure-venv
	@echo '============================ installing initial dependencies ==========================='
	$(VENV)/bin/pip install --upgrade pip setuptools wheel


build: build-initial-dependencies
	@echo '============================ installing initial dependencies ==========================='
	$(VENV)/bin/pip install -e .


test: build
	@echo '================================ running project tests ================================='
	$(VENV)/bin/pip install -e .[testing]
	$(VENV)/bin/pytest


migrate: build
	@echo '================================ running project tests ================================='
	$(VENV)/bin/initialize_pheroku_db ${CONFIG_FILE}


run: build migrate test
	@echo '===================================== running web ======================================'
	$(VENV)/bin/pserve ${CONFIG_FILE}


clean:
	@echo '==================================== cleaning env ======================================'
	rm $(VENV) -rf
	rm pheroku.sqlite
