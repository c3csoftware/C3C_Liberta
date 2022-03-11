public interface IMembroFilaSelector 
{
    List<SObject> obterMembrosFilaPorIdFila(String idFila);
    //Responsável por retornar uma lista de membro fila ordenado pela data de criação filtrando a disponibilidade para roletagem e o id fila
    List<SObject> buscarMembrosFilaOrdenadoPelaDataCriacaoFiltrandoDisponibilidadeRoletagemEIdFila(String idFila);
}