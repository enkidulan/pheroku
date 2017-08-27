.DEFAULT_GOAL := all

VENV?=.venv
ENV_OPTINOS?=
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


test:
	@echo '================================ running project tests ================================='
	$(VENV)/bin/pip install -e .[testing]
	$(VENV)/bin/pytest


migrate:
	@echo '================================ running project tests ================================='
	$(VENV)/bin/initialize_pheroku_db ${CONFIG_FILE}


serve:
	@echo '===================================== serving web ======================================'
	$(VENV)/bin/pserve ${CONFIG_FILE}


all: clean build migrate serve
	@echo '===================================== running web ======================================'


clean:
	@echo '==================================== cleaning env ======================================'
	rm $(VENV) -rf
	rm *.sqlite -rf
