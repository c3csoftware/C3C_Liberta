public interface IRespostaDomain 
{
    RespostaMapper obterMapper(); //Responsável por retornar a mapper
    SObject obterRegistro(); //Responsável por retornar o registro SObject
}