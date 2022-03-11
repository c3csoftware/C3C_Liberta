({
    selecionarLinha : function(component, event, helper) 
    {
        let valorSelecionado = event.currentTarget.firstElementChild.dataset.value;
        let listaOpcoes = component.get('v.listaOpcoes');

        let indexItemSelecionado = listaOpcoes.findIndex(x => x.value == valorSelecionado);

        for(let opcao of listaOpcoes)
            opcao.selecionado = false;

        if(indexItemSelecionado >= 0)
            listaOpcoes[indexItemSelecionado].selecionado = true;
    
        component.set('v.valorSelecionado', valorSelecionado);
        component.set('v.listaOpcoes', listaOpcoes);
    }
})