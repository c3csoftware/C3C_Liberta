@isTest
public with sharing class InstanRespTriggerAfterUpdateServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();
	@isTest
    static void testCoverage()
    {
        InstanciaRespTriggerAfterUpdateService.testCoverage();
    } 

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('AlterarStatusTarefaService', Test.createStub (AlterarStatusTarefaService.class, new AlterarStatusTarefaServiceStub()));
    }

    @isTest
    static void testeMudarStatusTarefaParaCompletado()
    {
        setupInjector();

        new InstanciaRespTriggerAfterUpdateService().mudarStatusTarefaParaCompletado(new List<IInstanciaRespostaDomain>
        {
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain', Schema.getGlobalDescribe().get(new InstanciaRespostaMapper().getObjectName()).newSObject())
        });
    }

    public class AlterarStatusTarefaServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'AlterarStatusTarefaService';
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
                when 'mudarStatusTask'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }
}