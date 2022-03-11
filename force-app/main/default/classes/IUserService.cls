public interface IUserService 
{
    IUserDomain obterUsuarioComId(String idRegistro);
    List<IUserDomain> upsertListaDeUsuarios(List<IUserDomain> listaUsuarios);
    IUserDomain obterUsuarioPorCodigoAssessor(String codigoAssessor);
    List<IUserDomain> obterUsuariosPorCodigoAssessor(List<String> listaCodigoAssessor); // Responsável por obter usuarios por codigo assessor 
    Map<String, IUserDomain> obterMapaUsuariosPorCodigoAssessor(List<String> listaCodigoAssessor); // Responsável por obter usuarios por codigo assessor 
    List<IUserDomain> obterListaUsuarioComIdFila(String idFila); //Responsável por retornar os usuários da fila informada
    //Responsável por retornar o usuário onde o id ActiveCampaign é igual ao informado
    IUserDomain obterUsuarioComIdActiveCampaign(String idActiveCampaign);
}