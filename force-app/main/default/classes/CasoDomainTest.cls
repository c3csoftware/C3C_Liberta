@isTest
public with sharing class CasoDomainTest 
{
    @isTest
    static void definirAtributosMapperTeste()
    {
        // GIVEN
        CasoDomain caso = new CasoDomain();

        // WHEN
        caso.definirAtributosMapper('Teste', 'Teste', 'Teste', 'Teste');
        
        // THEN
        System.assert(caso.proprietario == 'Teste', 'A propriedade proprietario precisa estar setada corretamente.');
    }

    @isTest
    static void definirAssessorQueRequisitouCasoTesteTrue()
    {
        // GIVEN
        CasoDomain caso = new CasoDomain();
        caso.categoria = 'BackOffice';
        caso.origem = 'Assessor';

        // WHEN
        caso.definirAssessorQueRequisitouCaso();
        
        // THEN
        System.assert(caso.casoCriadoPorAssessor == True, 'A propriedade casoCriadoPorAssessor deve estar True.');
    }

    @isTest
    static void definirAssessorQueRequisitouCasoTesteFalse()
    {
        // GIVEN
        CasoDomain caso = new CasoDomain();
        caso.categoria = 'BackOffice';
        caso.origem = 'Web';

        // WHEN
        caso.definirAssessorQueRequisitouCaso();
        
        // THEN
        System.assert(caso.casoCriadoPorAssessor == False, 'A propriedade casoCriadoPorAssessor deve estar False.');
    }

    @isTest
    static void definirProprietarioCasoPorFilaCategoriaTraderTeste()
    {
        // GIVEN
        CasoDomain caso = new CasoDomain();
        caso.categoria = 'BackOffice';
        caso.origem = 'Web';

        // WHEN
        caso.definirProprietarioCasoPorFilaCategoriaTrader('MD', new List<MembroEquipeMapper>(), new Map<String, GroupMapper>{
            '[Trader] Mesa Digital' => (GroupMapper) C3C_DIContainer_Injector.newInstance('GroupMapper')
        });
        
        // THEN
    }

    @isTest
    static void definirProprietarioCasoPorFilaCategoriaTraderTesteEquipe()
    {
        // GIVEN
        CasoDomain caso = new CasoDomain();
        caso.categoria = 'Trader';
        caso.origem = 'Web';

        MembroEquipeMapper membro = (MembroEquipeMapper) C3C_DIContainer_Injector.newInstance('MembroEquipeMapper', Schema.getGlobalDescribe().get('MembroEquipe__c').newSObject());

        membro.nomeEquipe = 'Equipe André Moreira';

        // WHEN
        caso.definirProprietarioCasoPorFilaCategoriaTrader('Teste', new List<MembroEquipeMapper>{membro}, new Map<String, GroupMapper>{
            '[Trader] Equipe André Moreira' => (GroupMapper) C3C_DIContainer_Injector.newInstance('GroupMapper')
        });
        
        // THEN
    }

    @isTest
    static void definirProprietarioCasoPorFilaCategoriaTraderTesteEquipeNull()
    {
        // GIVEN
        CasoDomain caso = new CasoDomain();
        caso.categoria = 'Trader';
        caso.origem = 'Web';

        MembroEquipeMapper membro = (MembroEquipeMapper) C3C_DIContainer_Injector.newInstance('MembroEquipeMapper', Schema.getGlobalDescribe().get('MembroEquipe__c').newSObject());

        membro.nomeEquipe = 'Outro';

        // WHEN
        try {
            caso.definirProprietarioCasoPorFilaCategoriaTrader('Teste', new List<MembroEquipeMapper>{membro}, new Map<String, GroupMapper>{
                '[Trader] Equipe André Moreira' => (GroupMapper) C3C_DIContainer_Injector.newInstance('GroupMapper')
            });
            
        } catch (Exception e) {
            
        }
        
        // THEN
    }

    @isTest
    static void definirProprietarioCasoPorFilaCategoriaTraderTesteNull()
    {
        // GIVEN
        CasoDomain caso = new CasoDomain();
        caso.categoria = 'BackOffice';
        caso.origem = 'Web';

        // WHEN
        try {
            caso.definirProprietarioCasoPorFilaCategoriaTrader(null, new List<MembroEquipeMapper>(), new Map<String, GroupMapper>());
        } catch (Exception e) {
            // THEN
            System.assert(e.getMessage() == 'O usuário não possue Papel cadastrado. Entre em contato com o Adminstrador do Sistema', 'O Throw deve estar funcionado');
        }
        
    }
}