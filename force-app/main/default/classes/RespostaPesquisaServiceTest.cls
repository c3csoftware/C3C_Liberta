@isTest
public with sharing class RespostaPesquisaServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_SObjectUnitOfWork.class, 'RespostaPesquisaServiceTest.fflib_SObjectUnitOfWorkStub');

        C3C_DIContainer_Injector.createInstance('RespostaPesquisaDomain', IRespostaPesquisaDomain.class, 'RespostaPesquisaServiceTest.RespostaPesquisaDomainStub');
    }    

    @isTest
    public static void testeInserirRespostaPesquisaPorBot()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        new RespostaPesquisaService().inserirRespostaPesquisaPorBot(new List<IRespostaPesquisaDomain>{ 
            (IRespostaPesquisaDomain) C3C_DIContainer_Injector.newInstance('RespostaPesquisaDomain', Schema.getGlobalDescribe().get('RespostaPesquisa__c').newSObject()), 
            (IRespostaPesquisaDomain) C3C_DIContainer_Injector.newInstance('RespostaPesquisaDomain', Schema.getGlobalDescribe().get('RespostaPesquisa__c').newSObject())
        });

        //THEN
        System.assert(mapClassTested.containsKey('fflib_SObjectUnitOfWork'), 'O método deveria chamar o fflib_SObjectUnitOfWork');

        System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('registerNew'), 'O método deveria chamar o método "registerNew" da fflib_SObjectUnitOfWork');

        System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('commitWork'), 'O método deveria chamar o método "commitWork" da fflib_SObjectUnitOfWork');
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

    public class RespostaPesquisaDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'RespostaPesquisaDomain';
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
                when 'obterRegistro'
                {
                    returnValue = Schema.getGlobalDescribe().get(new RespostaPesquisaMapper().getObjectName()).newSObject();
                }
            }

            return returnValue;
        }
    }
}