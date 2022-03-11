@isTest
public with sharing class AtualizarTarefaServiceAdapterTest 
{
    
    @isTest
    static void testeGetMapServiceMethodToClassMethod()
    {
        Map<String, String> mapa =  new AtualizarTarefaServiceAdapter().getMapServiceMethodToClassMethod();
        
        System.assert(mapa.size() > 0, 'O mapa não pode estar vazio');
    }
}