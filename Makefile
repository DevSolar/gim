.PHONY: all critic test clean

all: critic test

critic: gim.critic testgim.critic
test: gim.test

gim.critic: gim Makefile .perlcriticrc
	@touch $@; if ! perlcritic $< > $@ 2>&1; then echo $< critizised $$(grep "^[^ ]" $@ | wc -l) times; else rm $@; fi

testgim.critic: testgim gim Makefile .perlcriticrc
	@touch $@; if ! perlcritic --exclude RequireUseWarnings\|RequireBarewordIncludes $< > $@ 2>&1; then echo $< critizised $$(grep "^[^ ]" $@ | wc -l) times; else rm $@; fi

gim.test: gim testgim Makefile
	@touch $@; export LANG="en_US.UTF-8"; if ! ./testgim > /dev/null 2> $@; then echo $< tests failed; else rm $@; fi

clean:
	@$(RM) *.log *.test *.critic
