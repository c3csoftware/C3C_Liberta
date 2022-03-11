@isTest
public with sharing class PedidoDomainFactoryTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('PedidoDomain', PedidoDomain.class, 'PedidoDomainFactoryTest.PedidoDomainStub');
    }

    @isTest 
    static void testeConstruirListaPedidoDomainAPartirListaSobject()
    {
        setupInjector();

        List<PedidoDomain> listaPedidoDomain = PedidoDomainFactory.construirListaPedidoDomainAPartirListaSobject(new List<SObject> 
        {
            Schema.getGlobalDescribe().get('Pedido__c').newSObject()
        });

        System.assert(listaPedidoDomain.size() > 0, 'O método deveria retornar pelo menos um PedidoDomaia');
    }

    public class PedidoDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'PedidoDomain';
        }
    }
}