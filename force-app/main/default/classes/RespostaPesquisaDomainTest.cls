@isTest
public with sharing class RespostaPesquisaDomainTest 
{
    @isTest
    static void testeNewInstanceLista()
    {
        List<RespostaPesquisaDomain> respostaPesquisaDomain = (List<RespostaPesquisaDomain>) new RespostaPesquisaDomain().newInstance(new List<SObject>{
            Schema.getGlobalDescribe().get(new RespostaPesquisaMapper().getObjectName()).newSObject()
        });
    }

    @isTest
    static void testeNewInstance() 
    {
        RespostaPesquisaDomain respostaPesquisaDomain = (RespostaPesquisaDomain) new RespostaPesquisaDomain().newInstance(Schema.getGlobalDescribe().get(new RespostaPesquisaMapper().getObjectName()).newSObject());
        
        System.assert(respostaPesquisaDomain != null, 'O retorno do método deveria ser diferente de null');
        System.assert(respostaPesquisaDomain.obterRegistro() != null, 'O retorno do método obterRegistro deveria ser diferente de null');
        System.assert(respostaPesquisaDomain.obterMapper() != null, 'O retorno do método obterMapper deveria ser diferente de null');
    }

    @isTest
    static void testeNewInstanceMapa() 
    {
        RespostaPesquisaDomain respostaPesquisaDomain = (RespostaPesquisaDomain) new RespostaPesquisaDomain().newInstance(new Map<String, Object>{
            'codigoCliente' => 'Código Cliente',
            'nota' => 'Nota',
            'entidadePesquisa' => 'Entidade Pesquisa',
            'nomeCliente' => 'Nome do Cliente'
        });
        
        System.assert(respostaPesquisaDomain != null, 'O retorno do método deveria ser diferente de null');
    }

    @isTest
    static void testeNewInstanceNull() 
    {
        RespostaPesquisaDomain respostaPesquisaDomain = (RespostaPesquisaDomain) new RespostaPesquisaDomain().newInstance('Tiago');
        
        System.assert(respostaPesquisaDomain == null, 'O retorno do método deveria ser igual à null');
    }
}