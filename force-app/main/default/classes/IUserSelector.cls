public interface IUserSelector
{
    SObject obterUsuarioComId(String idRegistro); //Responsável por buscar usuário com o id do usuário
    List<SObject> obterUsuariosComListaDeId(List<String> listaDeIdRegistro); //Responsável por buscar uma lista de usuários com uma lista de id de usuário
    SObject obterUsuarioPorCodigoAssessor(String codigoAssessor);
    List<SObject> obterUsuariosPorCodigoAssessor(List<String> listaCodigoAssessor); // Responsável por buscar uma lista de usuários por lista de código de assessor
    List<SObject> buscarListaUsuarioComIdFila(String idFila); //Responsável por buscar uma lista de usuários da fila informada
    SObject buscarUsuarioComIdActiveCampaign(String idUsuarioActiveCampaign); //Responsável por buscar um usuário filtrando pelo id usuário ActiveCampaign
}