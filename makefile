all: doc test

.PHONY: test

clean:



AdditionsForToricVarieties_clean_tst:
	cd AdditionsForToricVarieties/tst && ./clean

CoherentSheavesOnToricVarieties_clean_tst:
	cd CoherentSheavesOnToricVarieties/tst && ./clean

cohomCalgInterface_clean_tst:
	cd cohomCalgInterface/tst && ./clean

H0Approximator_clean_tst:
	cd H0Approximator/tst && ./clean

SheafCohomologyOnToricVarieties_clean_tst:
	cd SheafCohomologyOnToricVarieties/tst && ./clean

SparseMatrices_clean_tst:
	cd SparseMatrices/tst && ./clean

SpasmInterface_clean_tst:
	cd SpasmInterface/tst && ./clean

ToolsForFPGradedModules_clean_tst:
	cd ToolsForFPGradedModules/tst && ./clean

ToricVarieties_clean_tst:
	cd ToricVarieties/tst && ./clean

TruncationsOfFPGradedModules_clean_tst:
	cd TruncationsOfFPGradedModules/tst && ./clean



AdditionsForToricVarieties_clean_doc:
	cd AdditionsForToricVarieties/doc && ./clean

CoherentSheavesOnToricVarieties_clean_doc:
	cd CoherentSheavesOnToricVarieties/doc && ./clean

cohomCalgInterface_clean_doc:
	cd cohomCalgInterface/doc && ./clean

H0Approximator_clean_doc:
	cd H0Approximator/doc && ./clean

SheafCohomologyOnToricVarieties_clean_doc:
	cd SheafCohomologyOnToricVarieties/doc && ./clean

SparseMatrices_clean_doc:
	cd SparseMatrices/doc && ./clean

SpasmInterface_clean_doc:
	cd SpasmInterface/doc && ./clean

ToolsForFPGradedModules_clean_doc:
	cd ToolsForFPGradedModules/doc && ./clean

ToricVarieties_clean_doc:
	cd ToricVarieties/doc && ./clean

TruncationsOfFPGradedModules_clean_doc:
	cd TruncationsOfFPGradedModules/doc && ./clean



AdditionsForToricVarieties_clean: AdditionsForToricVarieties_clean_tst AdditionsForToricVarieties_clean_doc
CoherentSheavesOnToricVarieties_clean: CoherentSheavesOnToricVarieties_clean_tst CoherentSheavesOnToricVarieties_clean_doc
cohomCalgInterface_clean: cohomCalgInterface_clean_tst cohomCalgInterface_clean_doc
H0Approximator_clean: H0Approximator_clean_tst H0Approximator_clean_doc
SheafCohomologyOnToricVarieties_clean: SheafCohomologyOnToricVarieties_clean_tst SheafCohomologyOnToricVarieties_clean_doc
SparseMatrices_clean: SparseMatrices_clean_tst SparseMatrices_clean_doc
SpasmInterface_clean: SpasmInterface_clean_tst SpasmInterface_clean_doc
ToolsForFPGradedModules_clean: ToolsForFPGradedModules_clean_tst ToolsForFPGradedModules_clean_doc
ToricVarieties_clean: ToricVarieties_clean_tst ToricVarieties_clean_doc
TruncationsOfFPGradedModules_clean: TruncationsOfFPGradedModules_clean_tst TruncationsOfFPGradedModules_clean_doc



clean_all: AdditionsForToricVarieties_clean CoherentSheavesOnToricVarieties_clean cohomCalgInterface_clean H0Approximator_clean SheafCohomologyOnToricVarieties_clean SparseMatrices_clean SpasmInterface_clean ToolsForFPGradedModules_clean ToricVarieties_clean TruncationsOfFPGradedModules_clean

clean_all_doc: AdditionsForToricVarieties_clean_doc CoherentSheavesOnToricVarieties_clean_doc cohomCalgInterface_clean_doc H0Approximator_clean_doc SheafCohomologyOnToricVarieties_clean_doc SparseMatrices_clean_doc SpasmInterface_clean_doc ToolsForFPGradedModules_clean_doc ToricVarieties_clean_doc TruncationsOfFPGradedModules_clean_doc

clean_all_tst: AdditionsForToricVarieties_clean_tst CoherentSheavesOnToricVarieties_clean_tst cohomCalgInterface_clean_tst H0Approximator_clean_tst SheafCohomologyOnToricVarieties_clean_tst SparseMatrices_clean_tst SpasmInterface_clean_tst ToolsForFPGradedModules_clean_tst ToricVarieties_clean_tst TruncationsOfFPGradedModules_clean_tst



AdditionsForToricVarieties_test:
	cd AdditionsForToricVarieties && make test

CoherentSheavesOnToricVarieties_test:
	cd CoherentSheavesOnToricVarieties && make test

cohomCalgInterface_test:
	cd cohomCalgInterface && make test

H0Approximator_test:
	cd H0Approximator && make test

SheafCohomologyOnToricVarieties_test:
	cd SheafCohomologyOnToricVarieties && make test

SparseMatrices_test:
	cd SparseMatrices && make test

SpasmInterface_test:
	cd SpasmInterface && make test

ToolsForFPGradedModules_test:
	cd ToolsForFPGradedModules && make test

ToricVarieties_test:
	cd ToricVarieties && make test

TruncationsOfFPGradedModules_test:
	cd TruncationsOfFPGradedModules && make test

test: AdditionsForToricVarieties_test CoherentSheavesOnToricVarieties_test cohomCalgInterface_test H0Approximator_test SheafCohomologyOnToricVarieties_test SparseMatrices_test SpasmInterface_test ToolsForFPGradedModules_test ToricVarieties_test TruncationsOfFPGradedModules_test

ci-test: doc
	cd AdditionsForToricVarieties && make ci-test
	cd CoherentSheavesOnToricVarieties && make ci-test
	cd cohomCalgInterface && make ci-test
	cd H0Approximator && make ci-test
	cd SheafCohomologyOnToricVarieties && make ci-test
	cd SparseMatrices && make ci-test
	cd SpasmInterface && make ci-test
	cd ToolsForFPGradedModules && make ci-test
	cd ToricVarieties && make doc
	cd TruncationsOfFPGradedModules && make doc



# BEGIN PACKAGE JANITOR
doc: doc_AdditionsForToricVarieties doc_CoherentSheavesOnToricVarieties doc_cohomCalgInterface doc_H0Approximator doc_SheafCohomologyOnToricVarieties doc_SparseMatrices doc_SpasmInterface doc_ToolsForFPGradedModules doc_ToricVarieties doc_TruncationsOfFPGradedModules

doc_AdditionsForToricVarieties:
	$(MAKE) -C AdditionsForToricVarieties doc

doc_CoherentSheavesOnToricVarieties:
	$(MAKE) -C CoherentSheavesOnToricVarieties doc

doc_cohomCalgInterface:
	$(MAKE) -C cohomCalgInterface doc

doc_H0Approximator:
	$(MAKE) -C H0Approximator doc

doc_SheafCohomologyOnToricVarieties:
	$(MAKE) -C SheafCohomologyOnToricVarieties doc

doc_SparseMatrices:
	$(MAKE) -C SparseMatrices doc

doc_SpasmInterface:
	$(MAKE) -C SpasmInterface doc

doc_ToolsForFPGradedModules:
	$(MAKE) -C ToolsForFPGradedModules doc

doc_ToricVarieties:
	$(MAKE) -C ToricVarieties doc

doc_TruncationsOfFPGradedModules:
	$(MAKE) -C TruncationsOfFPGradedModules doc

# END PACKAGE JANITOR
