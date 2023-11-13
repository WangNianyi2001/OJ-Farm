p?=
project?=$(p)
i?=
input?=$(i)

sources=('main.c' 'main.cpp')
target=main.exe
compiler=g++

entry:
ifeq ($(project), )
	@cat README;
else
	@make -s input=$(input) project=$(project) clean build run;
endif

clean:
	@echo;
ifeq ($(project), )
	@echo 'No project specified!';
else
	@echo 'Cleaning "'$(project)'"...'; \
	command="rm -f $(project)/$(target)"; \
	echo "$$ $$command"; eval $$command;
endif

build:
	@echo;
ifeq ($(project), )
	@echo 'No project specified!';
else
	@echo 'Building "'$(project)'"...'; \
	sources=$(sources); built=; \
	for source in "$${sources[@]}"; do \
		if [[ -f $(project)/$$source ]]; then \
			command="$(compiler) $(project)/$$source -o $(project)/$(target)"; \
			echo "$$ $$command"; eval $$command; \
			built=1; \
			echo "Built into [$(project)/$(target)]."; \
		fi; \
	done; \
	if [[ -z "$$built" ]]; then \
		echo 'No source found for "'$(project)'"!'; \
	fi;
endif

run:
	@echo;
ifeq ($(project), )
	@echo 'No project specified!';
else
ifeq ($(input), )
	@echo 'Running "'$(project)'"...'; \
	command="$(project)/$(target)"; \
	echo "$$ $$command"; \
	echo ; echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'; echo ; \
	eval $$command;
else
	@echo 'Running "'$(project)'" with input ['$(input)']...'; \
	command="$(project)/$(target) < $(input)"; \
	echo "$$ $$command"; \
	echo ; echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'; echo ; \
	eval $$command;
endif
endif