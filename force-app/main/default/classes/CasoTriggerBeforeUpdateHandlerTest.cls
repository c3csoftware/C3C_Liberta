@isTest
public with sharing class CasoTriggerBeforeUpdateHandlerTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupContext()
    {
        C3C_DIContainer_Injector.createInstance('CasoTriggerBeforeUpdateService', Test.createStub(ICasoTriggerBeforeUpdateService.class, new CasoTriggerBeforeUpdateServiceStub()));

    }

    // TESTES

    @isTest 
    static void mainEntryTeste()
    {
        // GIVEN
        setupContext();
        CasoTriggerBeforeUpdateHandler caso = new CasoTriggerBeforeUpdateHandler();
        // WHEN
        caso.mainEntry(new TriggerParameters(
            null, new List<SObject>{Schema.getGlobalDescribe().get('Case').newSObject()}, null, null, true, false, false, false, true, false, false 
        ));

        caso.inProgressEntry(null);

        caso.updateObjects();

        // THEN
    }

    // STUBS

    public class CasoTriggerBeforeUpdateServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'CasoTriggerBeforeUpdateService';
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
                when 'interarVezesQueCasoFoiReaberto'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }
}