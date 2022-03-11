@isTest
public with sharing class CadastrarAcessoAoCallboxDomainTest 
{
    @isTest 
    static void testeNewInstancePassandoListSobject()
    {
        // GIVEN

        // WHEN
        List<ICadastrarAcessoAoCallboxDomain> listCadastro = (List<ICadastrarAcessoAoCallboxDomain>) new CadastrarAcessoAoCallboxDomain().newInstance(new List<SObject>{
            Schema.getGlobalDescribe().get('CadastrarAcessoAoCallbox__e').newSObject()
        });

        // THEN
        System.assert(listCadastro.size() > 0, 'O retorno do método não pode ser vazio');
    }

    @isTest
    static void testeNewInstancePassandoSObject()
    {
        
        ICadastrarAcessoAoCallboxDomain cadastroDomain = (ICadastrarAcessoAoCallboxDomain) new CadastrarAcessoAoCallboxDomain().newInstance(Schema.getGlobalDescribe().get('CadastrarAcessoAoCallbox__e').newSObject());


        System.assert(cadastroDomain.obterMapper() != null, 'A mapper deveria estar diferente de null');
        System.assert(cadastroDomain.obterRegistro() != null, 'O registro deveria estar diferente de null');
    }

    @isTest
    static void testeNewInstancePassandoMap()
    {
        new CadastrarAcessoAoCallboxDomain().newInstance(new Map<String, Object>{
            'idUsuario' => 'idUsuario',
            'ramalUsuario' => 'ramalUsuario',
            'senhaCallbox' => 'senhaCallbox'
        });
    }

}