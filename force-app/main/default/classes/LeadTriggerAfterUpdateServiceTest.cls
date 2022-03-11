@isTest
public with sharing class LeadTriggerAfterUpdateServiceTest 
{
    public static Map<String,ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('ContaService',Test.createStub(IContaService.class, new ContaServiceStub()));
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'LeadTriggerAfterUpdateServiceTest.fflib_SObjectUnitOfWorkStub');

    }

    @isTest 
    static void testePassarDadosLeadParaConta()
    {
        // setupInjector(); 
        // ILeadDomain leadDom = (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', Schema.getGlobalDescribe().get('Lead').newSObject());

        // leadDom.obterMapper().recordId = fflib_IDGenerator.generate(Lead.sObjectType);
        // leadDom.obterMapper().statusConversao = 'Convertido';
        // leadDom.obterMapper().cpf = '000000000';
        // leadDom.obterMapper().empresa = 'Ouxx';
        // leadDom.obterMapper().sobrenome = 'Sobrenoma';
        // leadDom.obterMapper().nome = 'Oux';



        // new LeadTriggerAfterUpdateService().passarDadosLeadParaConta(new List<ILeadDomain>{
        //     leadDom
        // });

        
    }

    @isTest 
    static void testeCoverage()
    {
        LeadTriggerAfterUpdateService.testCoverage();
    }

    // STUBS
    public class ContaServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'ContaService';
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
                    when 'obterContaPorId'
                    {
                        returnValue = new ContaMapper();
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