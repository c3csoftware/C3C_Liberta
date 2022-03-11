@isTest
public with sharing class InstancRespTriggerAfterInsertHandlerTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('InstanciaRespTriggerAfterInsertService', Test.createStub(InstanciaRespTriggerAfterInsertService.class, new InstanciaRespTriggerAfterInsertServiceStub()));

        C3C_DIContainer_Injector.createInstance('IntegracaoResPerguntaParaCampoSObject', Test.createStub(IntegracaoResPerguntaParaCampoSObject.class, new IntegracaoResPerguntaParaCampoSObjectStub()));
    }

    @isTest
    static void testeMainEntry()
    {
        setupInjector();

        new InstancRespTriggerAfterInsertHandler().mainEntry(new TriggerParameters(null,new List<SObject>{
            Schema.getGlobalDescribe().get(new InstanciaRespostaMapper().getObjectName()).newSObject()
        },null,null,false,true,false,true,false,false,false));
    }

    public class InstanciaRespTriggerAfterInsertServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'InstanciaRespTriggerAfterInsertService';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
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
                when 'mudarStatusTarefaParaCompletado'
                {
                    returnValue = null;
                }

                when 'mudarStatusLeadParaPrimeiroContato'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }

    public class IntegracaoResPerguntaParaCampoSObjectStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'IntegracaoResPerguntaParaCampoSObject';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
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
                when 'integrarRespostasPerguntaComCamposSobject'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }

    public class InstanciaRespostaDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'InstanciaRespostaDomain';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}