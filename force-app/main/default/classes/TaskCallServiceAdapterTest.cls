@isTest
public with sharing class TaskCallServiceAdapterTest 
{
    @isTest
    static void testGetMapServiceMethodToClassMethod()
    {
        Map<String, String> valorDeRetorno =  new TaskCallServiceAdapter().getMapServiceMethodToClassMethod();

        System.assert(valorDeRetorno.size() > 0, 'O mapa não pode estar vazio');
    }
}