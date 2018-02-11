# vim: set ts=4 sw=4 ft=sh:
## Module 3 Chapter 5 Program
## Ashton S. Hellwig
## Feb 09 2018
## CSC160
##

# --- Variables ---
# Directories
SRC = src
TGT = obj
INCLUDES = -Iinclude
DBGOUT = target/debug
RELOUT = target/release
UDOCDIR = DOC/assigned
# Compiler
CXX = g++
CXXFLAGSREL = -Wall -std=c++17 -O2 $(INCLUDES)
CXXFLAGSDBG = -Wall -std=c++17 -g -ggdb $(INCLUDES)
SOURCES = $(wildcard $(SRC)/*.cpp)
DBGOBJS = $(addprefix $(TGT)/debug/, $(notdir $(SOURCES:.cpp=.o)))
RELOBJS = $(addprefix $(TGT)/release/, $(notdir $(SOURCES:.cpp=.o)))

# --- Rules ---

# All
## Build
all: debug user-doc-build release
## Removes object files
clean-all-obj: clean-dbg clean-rel
## Removes object files and binaries
clean-all: clean-all-dbg clean-all-rel user-doc-clean-all


# Doc
## Assigned
### Clean
user-doc-clean:
	rm -rf \
	$(UDOCDIR)/*.aux $(UDOCDIR)/*.bbl $(UDOCDIR)/*.blg $(UDOCDIR)/*.idx \
	$(UDOCDIR)/*.ind $(UDOCDIR)/*.lof $(UDOCDIR)/*.lot $(UDOCDIR)/*.out \
	$(UDOCDIR)/*.toc $(UDOCDIR)/*.acn $(UDOCDIR)/*.acr $(UDOCDIR)/*.alg \
	$(UDOCDIR)/*.glg $(UDOCDIR)/*.glo $(UDOCDIR)/*.gls $(UDOCDIR)/*.ist \
	$(UDOCDIR)/*.fls $(UDOCDIR)/*.log $(UDOCDIR)/*.fdblatexmk \
	$(UDOCDIR)/*.fdb_latexmk $(UDOCDIR)/*.synctex.gz
user-doc-clean-all: user-doc-clean
	$(user-doc-clean)
	rm -rf $(UDOCDIR)/*.pdf
### Build
user-doc-build: $(UDOCDIR)/%.tex
$(UDOCDIR)/%.tex: user-doc-clean
	$(user-doc-clean)
	cd $(UDOCDIR)
	latexmk -synctex=1 -interaction=nonstopmode -file-line-error \
	-jobname=$(UDOCDIR)/userdocs -pdf $(UDOCDIR)/userdocs.tex
	cd -


# Debug
## Run
run-debug: debug
	$(DBGOUT)/Chapter5-Debug.bin
## Build
debug: $(TGT)/debug/Chapter5-DBG
$(TGT)/debug/%.o: $(SRC)/%.cpp
	$(CXX) $(CXXFLAGSDBG) -c $< -o $@
$(TGT)/debug/Chapter5-DBG: $(DBGOBJS)
	$(CXX) $(LDFLAGS) $(DBGOBJS) -o $(DBGOUT)/Chapter5-Debug.bin
## Removes Object Files
clean-dbg:
	rm -rf $(TGT)/debug/*.o
## Removes binaries and object files for debugging builds
clean-all-dbg:
	rm -rf $(TGT)/debug/*.o $(DBGOUT)/*.bin


# Release
## Run
run-release: release
	$(RELOUT)/Chapter5-Release.bin
## Build
release: $(TGT)/release/Chapter5-REL
$(TGT)/release/%.o: $(SRC)/%.cpp
	$(CXX) $(CXXFLAGSREL) -c $< -o $@
$(TGT)/release/Chapter5-REL: $(RELOBJS)
	$(CXX) $(LDFLAGS) $(RELOBJS) -o $(RELOUT)/Chapter5-Release.bin
	cp $(UDOCDIR)/userdocs.pdf $(RELOUT)/userdocs.pdf
## Removes object files
clean-rel:
	rm -rf $(TGT)/release/*.o
## Removes binaries and object files for release builds
clean-all-rel:
	rm -rf $(TGT)/release/*.o $(RELOUT)/*.bin $(RELOUT)/*.pdf
