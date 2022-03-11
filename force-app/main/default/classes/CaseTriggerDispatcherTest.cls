@isTest
public with sharing class CaseTriggerDispatcherTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupContext()
    {
        C3C_DIContainer_Injector.createInstance('CasoTriggerAfterUpdateHandler', CasoTriggerAfterUpdateHandler.class, 'CaseTriggerDispatcherTest.CasoTriggerAfterUpdateHandlerStub');

        C3C_DIContainer_Injector.createInstance('CasoTriggerBeforeInsertHandler', CasoTriggerBeforeInsertHandler.class, 'CaseTriggerDispatcherTest.CasoTriggerBeforeInsertHandlerStub');

        C3C_DIContainer_Injector.createInstance('CasoTriggerBeforeUpdateHandler', CasoTriggerBeforeUpdateHandler.class, 'CaseTriggerDispatcherTest.CasoTriggerBeforeUpdateHandlerStub');
    }

    // Testes

    @isTest
    static void beforeInsertTeste()
    {
        // GIVEN
        setupContext();

        // WHEN 
         new CaseTriggerDispatcher().beforeInsert(new TriggerParameters(
            null, new List<SObject>{Schema.getGlobalDescribe().get('Case').newSObject()}, null, null, true, false, false, true, false, false, false
         ));

        // THEN
    }

    @isTest
    static void beforeUpdateTeste()
    {
        // GIVEN
        setupContext();

        // WHEN 
         new CaseTriggerDispatcher().beforeUpdate(new TriggerParameters(
            null, new List<SObject>{Schema.getGlobalDescribe().get('Case').newSObject()}, null, null, true, false, false, false, true, false, false
         ));

        // THEN
    }
    @isTest
    static void afterUpdateTeste()
    {
        // GIVEN
        setupContext();

        // WHEN 
         CaseTriggerDispatcher caso = new CaseTriggerDispatcher();
         
         caso.afterUpdate(new TriggerParameters(
            null, new List<SObject>{Schema.getGlobalDescribe().get('Case').newSObject()}, null, null, false, true, false, false, true, false, false
         ));

         caso.bulkBefore();
         caso.andFinally();

        // THEN
    }

    // STUBS

    public class CasoTriggerBeforeInsertHandlerStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String,ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return  'CasoTriggerBeforeInsertHandler';
        }
    }

    public class CasoTriggerBeforeUpdateHandlerStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String,ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return  'CasoTriggerBeforeUpdateHandler';
        }
    }

    public class CasoTriggerAfterUpdateHandlerStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String,ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return  'CasoTriggerAfterUpdateHandler';
        }
    }
}