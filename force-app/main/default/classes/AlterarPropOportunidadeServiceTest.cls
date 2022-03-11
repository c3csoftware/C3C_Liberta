@isTest
public class AlterarPropOportunidadeServiceTest 
{
	public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'AlterarPropOportunidadeServiceTest.fflib_SObjectUnitOfWorkStub');
        
        C3C_DIContainer_Injector.createInstance('OportunidadeDomain', IOportunidadeDomain.class, 'AlterarPropOportunidadeServiceTest.OportunidadeDomainStub');
    }
    
	@isTest
    static void testeMudarProprietarioLead()
    {
        setupInjector();
        
        new AlterarProprietarioOportunidadeService().mudarProprietarioOportunidade(new Map<String, Object> {
           'idRegistro' => 'teste',
           'idProprietario' => 'teste'
        });
    }
    
    public class OportunidadeDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'OportunidadeDomain';
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

                        returnValue = Schema.getGlobalDescribe().get(new OportunidadeMapper().getObjectName()).newSObject();
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