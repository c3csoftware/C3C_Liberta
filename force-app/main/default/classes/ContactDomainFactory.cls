public without sharing class ContactDomainFactory 
{
    public static IContactDomain novaInstanciaContatoComNumeroCelular(String numeroCelular)
    {
        IContactDomain contato = (IContactDomain) C3C_DIContainer_Injector.newInstance('ContactDomain');
        ContactMapper contatoMapper = contato.obterMapper();

        contatoMapper.sobrenome = 'Contato - ('+numeroCelular+')';
        contatoMapper.celular = numeroCelular;

        return contato;
    }
}