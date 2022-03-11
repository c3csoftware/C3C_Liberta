@isTest
public with sharing class CalendarioDeEventosServiceAdapterTest 
{
    @isTest
    static void testeGetMapServiceMethodToClassMethod()
    {
        Map<String, String> mapAgendar = new CalendarioDeEventosServiceAdapter().getMapServiceMethodToClassMethod();

        System.assert(mapAgendar.size() > 0, 'O retorno do método não pode ser vazio');
    }
}