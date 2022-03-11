@isTest
public with sharing class InstanRespTriggerAfterInsertServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('AlterarStatusTarefaService', Test.createStub(AlterarStatusTarefaService.class, new AlterarStatusTarefaServiceStub()));
        C3C_DIContainer_Injector.createInstance('BuscarInformacoesTarefaService', Test.createStub(BuscarInformacoesTarefaService.class, new BuscarInformacoesTarefaServiceStub()));
        C3C_DIContainer_Injector.createInstance('AlterarStatusLeadService', Test.createStub(AlterarStatusLeadService.class, new AlterarStatusLeadServiceStub()));
    }
    
    @isTest
    static void testeMudarStatusTarefaParaCompletado()
    {
        setupInjector();

        new InstanciaRespTriggerAfterInsertService().mudarStatusTarefaParaCompletado(new List<IInstanciaRespostaDomain>
        {
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain', Schema.getGlobalDescribe().get(new InstanciaRespostaMapper().getObjectName()).newSObject())
        });
    }

    @isTest
    static void testeMudarStatusLeadParaPrimeiroContato()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new InstanciaRespTriggerAfterInsertService().mudarStatusLeadParaPrimeiroContato(new List<IInstanciaRespostaDomain>
        {
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain', Schema.getGlobalDescribe().get(new InstanciaRespostaMapper().getObjectName()).newSObject())
        });

        // THEN
    }


    @isTest
    static void mudarStatusCasoParaEncerradoTeste()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new InstanciaRespTriggerAfterInsertService().mudarStatusCasoParaEncerrado(new List<IInstanciaRespostaDomain>
        {
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain', Schema.getGlobalDescribe().get(new InstanciaRespostaMapper().getObjectName()).newSObject())
        });

        // THEN
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

    public class BuscarInformacoesTarefaServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'BuscarInformacoesTarefaService';
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
                when 'obterTarefaPorListId'
                {
                    returnValue = new List<ITaskDomain>{
                        (ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain', Schema.getGlobalDescribe().get('Task').newSObject())
                    };
                }
            }
            
            return returnValue;
        }
    }

    public class AlterarStatusLeadServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'AlterarStatusLeadService';
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
                when 'mudarStatusLead'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }
}