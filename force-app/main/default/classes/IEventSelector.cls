public interface IEventSelector
{
    List<SObject> buscarEventosDeUsuariosDaFilaComDataDeInicioETermino(String idFila, Datetime dataDeInicio, Datetime dataDeTermino);
    List<SObject> buscarEventosDeUsuariosDaFilaDoMesAtual(String idFila);
    List<SObject> buscarEventosDoMesComIdRelativoIdProprietario(String idRelativo, String idProprietario);
    //Responsável por retornar os evento dos usuários informados, a partir da data de inicio e termino informada.
    List<SObject> buscarEventosDeUsuariosDaFilaSemUsuariosInformadosComDataDeInicioETermino(String idFila, Set<String> idsUsuario, Datetime dataDeInicio, Datetime dataDeTermino);
    List<SObject> buscarTodosEventosComDataDeInicioETermino(Datetime activityDataHora, Boolean conjuntoDeLembretes); //Responsável por retornar todos os evento dos usuários a partir da data de inicio e termino informada.

}