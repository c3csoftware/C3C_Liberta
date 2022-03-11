@isTest
public without sharing class NegocioDomainTest 
{
    @isTest 
    static void testeDefinirFilaDoNegocio()
    {
        NegocioDomain negocio = new NegocioDomain();
        negocio.definirFilaDoNegocio('NomeFila', 'idFila');

        System.assert(negocio.nomeFila == 'NomeFila', 'negocio.nomeFila deve receber o mesmo valor que está sendo passado no parâmetro do método');
        System.assert(negocio.proprietario == 'idFila', 'negocio.proprietario deve receber o mesmo valor que está sendo passado no parâmetro do método');
    }

    @isTest 
    static void testeDefinirFilaDoNegocioPassandoNullParaIdFila()
    {
        NegocioDomain negocio = new NegocioDomain();
        negocio.definirFilaDoNegocio('NomeFila', null);

        System.assert(negocio.nomeFila == 'NomeFila', 'negocio.nomeFila deve receber o mesmo valor que está sendo passado no parâmetro do método');
    }
    
    @isTest 
    static void testeDefinirUsuarioProprietarioDoNegocio()
    {
        NegocioDomain negocio = new NegocioDomain();
        negocio.definirUsuarioProprietarioDoNegocio('idFila');
        
        System.assert(negocio.proprietario == 'idFila', 'negocio.proprietario deve receber o mesmo valor que está sendo passado no parâmetro do método');
    }

    @isTest 
    static void testeDefinirUsuarioProprietarioDoNegocioPassandoNull()
    {
        NegocioDomain negocio = new NegocioDomain();
        negocio.definirUsuarioProprietarioDoNegocio(null);
        
        System.assert(negocio.usuarioNaoIdentificado == true, 'negocio.usuarioNaoIdentificado deve estar como true');
    }
}