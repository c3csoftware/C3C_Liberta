@isTest
public with sharing class AcessoCallBoxServiceAdapterTest 
{   
    @isTest
    static void testeGetMapServiceMethodToClassMethod()
    {
        Map<String,String> mapa = new AcessoCallBoxServiceAdapter().getMapServiceMethodToClassMethod();

        System.assert(mapa.size() > 0, 'O método deve retonar um mapa preenchido');
    }
}