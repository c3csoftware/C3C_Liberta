@isTest
public with sharing class UserServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'UserServiceTest.fflib_SObjectUnitOfWorkStub');

        C3C_DIContainer_Injector.createInstance('UserDomain', IUserDomain.class, 'UserServiceTest.UserDomainStub');

        C3C_DIContainer_Injector.createInstance('UserSelector', Test.createStub(IUserSelector.class, new UserSelectorStub()));
    }

    @isTest
    static void testeObterUsuarioComId()
    {
        //GIVEN
        setupInjector();
        //WHEN
        IUserDomain result = new UserService().obterUsuarioComId(fflib_IDGenerator.generate(User.sObjectType));

        //THEN
        System.assert(mapClassTested.containsKey('UserSelector'), 'Método deveria chamar a classe "UserSelector"');

        System.assert(mapClassTested.get('UserSelector').containsMethod('obterUsuarioComId'), 'Método deveria chamar o método "obterUsuarioComId" da UserSelector');
    } 

    @isTest
    static void testeUpsertListaDeUsuarios()
    {
        //GIVEN
        setupInjector();

        //WHEN
        List<IUserDomain> result = new UserService().upsertListaDeUsuarios(new List<IUserDomain>{
            (IUserDomain) C3C_DIContainer_Injector.newInstance('UserDomain', Schema.getGlobalDescribe().get('User').newSObject())
        });

        //THEN
        System.assert(mapClassTested.containsKey('fflib_SObjectUnitOfWork'), 'Método deveria chamar a classe "fflib_SObjectUnitOfWork"');
    }

    @isTest
    static void testCoverage()
    {
        UserService.testCoverage();
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
    
    public class UserDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'UserDomain';
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
            System.debug('entrou aqui');
            returnValue = (IUserDomain) C3C_DIContainer_Injector.newInstance('UserDomain');

            switch on stubbedMethodName
            {
                when 'obterRegistro'
                {
                    returnValue = Schema.getGlobalDescribe().get('User').newSObject();
                }
            }

            return returnValue;
        }
    }
    
    public class UserSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'UserSelector';
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
                when 'obterUsuarioComId'
                {
                    returnValue = Schema.getGlobalDescribe().get(new UserMapper().getObjectName()).newSObject();
                }
            }

            return returnValue;
        }
    }
}