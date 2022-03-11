public interface IPerfilClienteDomain 
{
    PerfilClienteMapper construirPerfilClienteMapper(SObject perfilCliente);
    List<PerfilClienteMapper> construirListPerfilClienteMapper(List<SObject> listConta);
}