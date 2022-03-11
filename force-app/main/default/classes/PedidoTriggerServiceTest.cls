@isTest
public with sharing class PedidoTriggerServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('ContaSelector', Test.createStub(IContaSelector.class, new ContaSelectorStub()));

        C3C_DIContainer_Injector.createInstance('ContaDomain', IContaDomain.class, 'PedidoTriggerServiceTest.ContaDomainStub');

        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'PedidoTriggerServiceTest.fflib_SObjectUnitOfWorkStub');
    }

    @isTest
    static void vincularPedidosAsContasTest()
    {
        setupInjector();

        PedidoDomain pedido = (PedidoDomain) C3C_DIContainer_Injector.newInstance('PedidoDomain', Schema.getGlobalDescribe().get('Pedido__c').newSObject());

        pedido.cpfCnpj = '12312312312';

        new PedidoTriggerService().vincularPedidosAsContas(new List<PedidoDomain>{
            pedido, pedido
        });

    }

    @isTest
    static void vincularCriarContasParaPedidos()
    {
        setupInjector();

        PedidoDomain pedido = (PedidoDomain) C3C_DIContainer_Injector.newInstance('PedidoDomain', Schema.getGlobalDescribe().get('Pedido__c').newSObject());

        pedido.cpfCnpj = '12312312312';

        new PedidoTriggerService().criarContasParaPedidos(new List<PedidoDomain>{
            pedido
        });

    }

    // STUBS
    public class ContaSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'ContaSelector';
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
                when 'obterContasPorIdsChaveExterna'
                {
                    IContaDomain conta = (IContaDomain) C3C_DIContainer_Injector.newInstance('ContaDomain', Schema.getGlobalDescribe().get('Account').newSObject());

                    conta.obterMapper().idChaveExterna = '123.123.123-12';
                    fflib_IDGenerator.generate(Account.sObjectType);

                    returnValue = new List<SObject>{
                        conta.obterRegistro()
                    };
                }
            }

            return returnValue;
        }
    }

    public class ContaDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'ContaDomain';
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
                    ContaMapper conta = (ContaMapper) C3C_DIContainer_Injector.newInstance('ContaMapper', Schema.getGlobalDescribe().get('Account').newSObject());

                    conta.idChaveExterna = 'Teste';
                    conta.recordId = fflib_IDGenerator.generate(Account.sObjectType);

                    returnValue = conta;
                }
            }

            return returnValue;
        }

    }

    public class fflib_SObjectUnitOfWorkStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'fflib_SObjectUnitOfWork';
        }
    }
}