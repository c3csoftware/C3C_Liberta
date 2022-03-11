@isTest
public with sharing class AtualizarTarefaServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('TaskSelector', Test.createStub(ITaskSelector.class, new TaskSelectorStub()));
        C3C_DIContainer_Injector.createInstance('LeadFilhoSelector', Test.createStub(ILeadFilhoSelector.class, new LeadFilhoSelectorStub()));
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_SObjectUnitOfWork.class, 'AtualizarTarefaServiceTest.fflib_SObjectUnitOfWorkStub');
        C3C_DIContainer_Injector.createInstance('TaskDomain', ITaskDomain.class, 'AtualizarTarefaServiceTest.TaskDomainStub');
        C3C_DIContainer_Injector.createInstance('LeadFilhoDomain', ILeadFilhoDomain.class, 'AtualizarTarefaServiceTest.LeadFilhoDomainStub');
    }

    @isTest
    static void testeAtualizarWhatIdParaWhoId()
    {
        setupInjector();

        new AtualizarTarefaService().atualizarWhatIdParaWhoId('Teste');
    }

    // STUBS

    public class TaskSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TaskSelector';
        }

        public override Map<String,ClassTested> getMapClassTested()
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
                when 'obterTarefaPorId'
                {
                    returnValue = Schema.getGlobalDescribe().get('Task').newSObject();
                }
            }
            
            return returnValue;
        }
    }

    public class LeadFilhoSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadFilhoSelector';
        }

        public override Map<String,ClassTested> getMapClassTested()
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
                when 'obterLeadFilhoPorId'
                {
                    returnValue = Schema.getGlobalDescribe().get('LeadFilho__c').newSObject();
                }
            }
            
            return returnValue;
        }
    }

    public class LeadFilhoDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadFilhoDomain';
        }

        public override Map<String,ClassTested> getMapClassTested()
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
                when 'obterMapper'
                {   
                    LeadFilhoMapper leadF = (LeadFilhoMapper) C3C_DIContainer_Injector.newInstance('LeadFilhoMapper');
                    leadF.lead = 'Lead viu';
                    returnValue = leadF;
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

        public override Map<String,ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    public class TaskDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TaskDomain';
        }

        public override Map<String,ClassTested> getMapClassTested()
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
                when 'obterMapper'
                {   
                    TaskMapper task = (TaskMapper) C3C_DIContainer_Injector.newInstance('TaskMapper');
                    task.relativo = 'Relativo viu';
                    returnValue = task;
                }

                when 'obterRegistro'
                {   
                    returnValue = Schema.getGlobalDescribe().get('Task').newSObject();
                }
            }
            
            return returnValue;
        }
    }
}