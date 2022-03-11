@isTest
public with sharing class CasoMapperTest 
{
    @isTest
    static void newInstanceTest()
    {
        new CasoMapper().newInstance(Schema.getGlobalDescribe().get('Case').newSObject());
    }

    @isTest
    static void getObjectNameTest()
    {
        new CasoMapper().getObjectName();
    }
}