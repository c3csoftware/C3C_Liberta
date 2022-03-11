@isTest
public with sharing class ChecklistServiceAdapterTest 
{
    @isTest
    static void testGetMapServiceMethodToClassMethod()
    {
        Map<String, String> valorDeRetorno =  new ChecklistServiceAdapter().getMapServiceMethodToClassMethod();

        System.assert(valorDeRetorno.size() > 0, 'O mapa não pode estar vazio');
    }
}