@isTest
public with sharing class CadastrarAcessoAoCallboxMapperTest 
{
    @isTest
    public static void testeGetObjectName()
    {
        // WHEN
        string nomeDaAPIObjeto = new CadastrarAcessoAoCallboxMapper().getObjectName();

        // THEN
        System.assertEquals('CadastrarAcessoAoCallbox__e', nomeDaAPIObjeto, 'O nome do objeto deveria ser "CadastrarAcessoAoCallbox"');
    }

    @isTest
    public static void testeNewInstance()
    {
        //WHEN
        CadastrarAcessoAoCallboxMapper CadastrarAcessoAoCallboxMpp = (CadastrarAcessoAoCallboxMapper) new CadastrarAcessoAoCallboxMapper().newInstance(
            Schema.getGlobalDescribe().get(
                new CadastrarAcessoAoCallboxMapper().getObjectName()
            ).newSObject());

        // THEN
        System.assert(CadastrarAcessoAoCallboxMpp != null, 'Deveria retornar uma instância de CadastrarAcessoAoCallboxMapper');
    }

    @isTest
    static void testeNewInstancePassandoMap()
    {
        CadastrarAcessoAoCallboxMapper CadastrarAcessoAoCallboxMapper = (CadastrarAcessoAoCallboxMapper) new CadastrarAcessoAoCallboxMapper().newInstance(new Map<String, Object>{
            'idUsuario' => 'idUsuario',
            'ramalUsuario' => 'ramalUsuario',
            'senhaCallbox' => 'senhaCallbox'
        });

        System.assert(CadastrarAcessoAoCallboxMapper != null, 'Deveria retornar uma instância de CadastrarAcessoAoCallboxMapper');
    }

    @isTest
    public static void testeNewInstanceNull()
    {
        // WHEN
        CadastrarAcessoAoCallboxMapper CadastrarAcessoAoCallboxMpp = (CadastrarAcessoAoCallboxMapper) new CadastrarAcessoAoCallboxMapper().newInstance('');

        // THEN
        System.assert(CadastrarAcessoAoCallboxMpp == null, 'Não deveria retornar uma instância de CadastrarAcessoAoCallboxMapper');
    }
}