@isTest
public with sharing class MembroFilaMapperTest 
{
    @isTest
    public static void testeGetObjectName()
    {
        //WHEN
        new UserMapper().getObjectName();     
    }
    
    @isTest
    public static void testNewInstance()
    {
        new UserMapper().newInstance(Schema.getGlobalDescribe().get(
        	new UserMapper().getObjectName()
        ).newSObject());
    }  

    @isTest
    static void testCoverage()
    {
        MembroFilaMapper.testCoverage();
    }
}