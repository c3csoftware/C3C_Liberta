@isTest
public with sharing class CasoTriggerAfterUpdateHandlerTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupContext()
    {
        C3C_DIContainer_Injector.createInstance('CasoTriggerAfterUpdateService', Test.createStub(ICasoTriggerAfterUpdateService.class, new CasoTriggerAfterUpdateServiceStub()));

    }

    // TESTES

    @isTest 
    static void mainEntryTeste()
    {
        // GIVEN
        setupContext();
        CasoTriggerAfterUpdateHandler caso = new CasoTriggerAfterUpdateHandler();
        // WHEN
        caso.mainEntry(new TriggerParameters(
            null, new List<SObject>{Schema.getGlobalDescribe().get('Case').newSObject()}, null, null, false, true, false, false, true, false, false 
        ));

        caso.inProgressEntry(null);

        caso.updateObjects();

        // THEN
    }

    // STUBS

    public class CasoTriggerAfterUpdateServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'CasoTriggerAfterUpdateService';
        }

        public override Object methodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            
            switch on stubbedMethodName
            {
                when 'dispararTarefaNpsParaAssessor'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }

}