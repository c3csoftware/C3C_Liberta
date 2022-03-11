@isTest
public with sharing class CasoTriggerBeforeInsertServiceTest 
{
    @isTest
    static void atualizarCampoAssessorTest()
    {
        // GIVEN
        CasoDomain caso = (CasoDomain) C3C_DIContainer_Injector.newInstance('CasoDomain', Schema.getGlobalDescribe().get('Case').newSObject());

        caso.categoria = 'Trader';
        caso.origem = 'Assessor';

        // WHEN
        new CasoTriggerBeforeInsertService().atualizarCampoAssessor(new List<CasoDomain>{
            caso
        });

        // THEN 
        System.assert(caso.casoCriadoPorAssessor == true, 'A propriedade casoCriadoPorAssessor deve estar true');

    }

    @isTest
    static void atualizarCampoAssessorTestFalse()
    {
        // GIVEN
        CasoDomain caso = (CasoDomain) C3C_DIContainer_Injector.newInstance('CasoDomain', Schema.getGlobalDescribe().get('Case').newSObject());

        caso.categoria = 'Trader';
        caso.origem = 'Web';

        // WHEN
        new CasoTriggerBeforeInsertService().atualizarCampoAssessor(new List<CasoDomain>{
            caso
        });

        // THEN 
        System.assert(caso.casoCriadoPorAssessor == false, 'A propriedade casoCriadoPorAssessor deve estar false');

    }
}