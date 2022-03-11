@isTest
public with sharing class CasoTriggerBeforeInsertHandlerTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();
    
    static void setupContext()
    {

        C3C_DIContainer_Injector.createInstance('CasoTriggerBeforeInsertService', Test.createStub(ICasoTriggerBeforeInsertService.class, new CasoTriggerBeforeInsertServiceStub()));

        C3C_DIContainer_Injector.createInstance('ManipuladorCasoPorFilaService', Test.createStub(IManipuladorCasoPorFilaService.class, new ManipuladorCasoPorFilaServiceStub()));
    }

    // TESTES

    @isTest
    static void mainEntryTeste()
    {
        // GIVEN
        setupContext();
        CasoTriggerBeforeInsertHandler caso = new CasoTriggerBeforeInsertHandler();

        // WHEN
        caso.mainEntry(new TriggerParameters(
            null, new List<SObject>{Schema.getGlobalDescribe().get('Case').newSObject()}, null, null, true, false, false, true, false, false, false
        ));
        caso.inProgressEntry(null);
        caso.updateObjects();

        // THEN
    }


    // STUBS

    public class CasoTriggerBeforeInsertServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'CasoTriggerBeforeInsertService';
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
                when 'atualizarCampoAssessor'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }

    public class ManipuladorCasoPorFilaServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'ManipuladorCasoPorFilaService';
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
                when 'orquestrarFilaParaDefinirProprietarioCaso'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }
}