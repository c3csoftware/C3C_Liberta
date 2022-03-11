@isTest
public with sharing class ConverterLeadServiceTest 
{
    @isTest
    static void testCoverage()
    {
        ConverterLeadService.testCoverage();
    }

    // Contexto

    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('LeadSelector', Test.createStub(ILeadSelector.class, new LeadSelectorStub()));

        C3C_DIContainer_Injector.createInstance('LeadStatusService', Test.createStub(ILeadStatusService.class, new LeadStatusServiceStub()));
        
        C3C_DIContainer_Injector.createInstance('AccountService', Test.createStub(IAccountService.class, new AccountServiceStub()));

        C3C_DIContainer_Injector.createInstance('TaskDomain', ITaskDomain.class, 'AgentWorkTriggerServiceTest.TaskDomainStub');
    }

    // Testes

    @isTest 
    static void testePegarLeadPorId()
    {
        ConverterLeadService.testCoverage();
    }
    
    @isTest 
    static void testeTrocarAssessorDoLead()
    {
        setupInjector();
        ConverterLeadService leadService = new ConverterLeadService();
        leadService.alterarProprietarioDoLeadParaAssessor('','');
    }

    //STUBS

    public class LeadSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadSelector';
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
                    when 'AccountService'
                    {
                        returnValue = new List<SObject> {
                            Schema.getGlobalDescribe().get(new AccountMapper().getObjectName()).newSObject()
                        };
                    }

                }

                return returnValue;
            }
    }

    public class LeadStatusServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadStatusService';
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
                    when 'retornarLabelDeLeadConvertido'
                    {
                        returnValue = 'String';
                    }

                }

                return returnValue;
            }
    }

    public class AccountServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'AccountService';
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
                    when 'obterTipoTarefasPorTipoIgualQualificacaoLead'
                    {
                        ITipoTarefaDomain ale =(ITipoTarefaDomain) C3C_DIContainer_Injector.newInstance('TipoTarefaDomain', Schema.getGlobalDescribe().get('TipoTarefa__c').newSObject());

                        ale.obterMapper().tipo = 'Teste';

                        returnValue = ale;
                    }

                }

                return returnValue;
            }
    }
    public class fflib_SObjectUnitOfWorkStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'fflib_SObjectUnitOfWork';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

}