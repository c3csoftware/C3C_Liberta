({
    doInit : function(component,event,helper){
        var meses = helper.getMeses();
        component.set('v.mes', component.get('v.mesExtenso') != undefined ? meses.indexOf(component.get('v.mesExtenso')) : new Date().getMonth());
        component.set('v.mesExtenso', meses[component.get('v.mes')]);
        component.set('v.ano', component.get('v.ano') != undefined ? component.get('v.ano') : new Date().getFullYear())
        helper.getDiasMes(component, event, helper);
    },
    getMesesObj : function(component){
        let meses = this.getMeses();
        let mesesVisiveis = component.get('v.mesesVisiveis');
        let mesesObj = [];

        console.log('mesesVisiveis: '+ mesesVisiveis);

        for(let i = 0; i < meses.length; i++)
        {
            mesesObj.push({
                value: i, 
                label: meses[i],
                disabled: !mesesVisiveis.includes(i)
            });
        }

        return mesesObj;
    },
    getMeses : function(){
        return ['Janeiro', 'Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'];
    },
    getDiasMes : function(component, event, helper) {
        var diasMes = [];
        var meses = ['Janeiro', 'Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'];
        var hoje = new Date();
        let dataReference = component.get('v.data') != undefined ? component.get('v.data').split('/') : component.get('v.data');
        var mesFiltro = component.get('v.mes');
        var anoFiltro = component.get('v.ano');

        var dataReferenceMes = new Date(anoFiltro, mesFiltro, 1);
        var dias = [];
        var mes = meses[dataReferenceMes.getMonth()];

        let dataVisiveis = component.get('v.dataVisiveis');

        console.log('dataVisiveis: '+dataVisiveis);

        for(var j = dataReferenceMes.getDay();j >= 1;j--){
            var data = new Date(anoFiltro, mesFiltro, 1-j);
            var dia = {
                numero: data.getDate(),
                disabled: true,
                diaAtual: false,
                eventos: []
            };
            
            dias.push(dia);
        }

        for(var j = 0;j < (new Date(anoFiltro, mesFiltro+1, 0)).getDate();j++){
            var dia = {
                numero: (new Date(anoFiltro, mesFiltro, 1+j)).getDate(),
                disabled: false,
                diaAtual: false,
                eventos: [],
                selecionado: false
            };

            let dateFiltro = new Date(anoFiltro, mesFiltro, 1+j);

            if(hoje.getFullYear() == anoFiltro && hoje.getMonth() == mesFiltro && hoje.getDate() == (dateFiltro).getDate())
                dia.diaAtual = true;

            if(component.get('v.data') == 'HOJE' && hoje.getFullYear() == anoFiltro && hoje.getMonth() == mesFiltro && hoje.getDate() == (dateFiltro).getDate())
                dia.selecionado = true;

            if(dataReference != undefined && parseInt(dataReference[2]) == anoFiltro && parseInt(dataReference[1]) == mesFiltro && parseInt(dataReference[0]) == (dateFiltro).getDate())
                dia.selecionado = true;

            dias.push(dia);
        }

        for(var j = 0;j < (6 - (new Date(anoFiltro, mesFiltro+1, 0)).getDay());j++){
            var dia = {
                numero: (new Date(anoFiltro, mesFiltro, 1+j)).getDate(),
                disabled: true,
                diaAtual: false,
                eventos: []
            };
            dias.push(dia);
        }

        component.get('v.eventos').map(evento => {
            if(evento == undefined)
                return;

            let dateFiltroStartMonth = new Date(anoFiltro, mesFiltro, 1);
            let dateFiltroEndMonth = helper.addMonths(new Date(anoFiltro, mesFiltro, 1), 1);
            dateFiltroEndMonth = new Date(dateFiltroEndMonth.getFullYear(), dateFiltroEndMonth.getMonth(), 0, 23, 59, 59);

            let diaInicioEvento;
            let diaEncerramentoEvento;

            if(evento.dataInicio >= dateFiltroStartMonth && evento.dataInicio <= dateFiltroEndMonth){
                if(evento.dataEncerramento <= dateFiltroEndMonth){
                    diaInicioEvento = evento.dataInicio.getDate();
                    diaEncerramentoEvento = evento.dataEncerramento.getDate();
                }else{
                    diaInicioEvento = evento.dataInicio.getDate();
                    diaEncerramentoEvento = hoje.getDate();
                }
            }else if(evento.dataInicio < dateFiltroStartMonth && evento.dataEncerramento >= dateFiltroStartMonth){
                if(evento.dataEncerramento <= dateFiltroEndMonth){
                    diaInicioEvento = dateFiltroStartMonth.getDate();
                    diaEncerramentoEvento = evento.dataEncerramento.getDate();
                }else{
                    diaInicioEvento = dateFiltroStartMonth.getDate();
                    diaEncerramentoEvento = hoje.getDate();
                }
            }

            for(let i = diaInicioEvento; i <= diaEncerramentoEvento; i++){
                let indexDia = dias.findIndex(x => x.numero == i && x.disabled == false);
                if(indexDia >= 0)
                    dias[indexDia].eventos.push(evento);
            }
        });

        diasMes.push({
            mes,
            dias
        });

        component.set('v.diasMes',diasMes);
        
    },
    select : function(component, event, helper){
        helper.clearSelect(component, event, helper);
        var hoje = new Date();
        var evento = component.getEvent('selectDataCalendario');

        var dia = parseInt(parseInt(event.currentTarget.name).length == 1 ? '0'+event.currentTarget.name : event.currentTarget.name);
        var mes = parseInt(component.get('v.mes')+1).length == 1 ? '0'+(component.get('v.mes')+1) : (component.get('v.mes')+1);
        var ano = parseInt((component.get('v.ano')).length == 1 ? '0'+component.get('v.ano') : component.get('v.ano'));
        
        event.currentTarget.setAttribute('class','calendarDay '+(event.currentTarget.getAttribute('class').includes('selectDay') ? 'selecionado2' : 'selecionado' )+' cursor-pointer '+(event.currentTarget.getAttribute('class').includes('selectDay') ? 'selectDay' : (hoje.getFullYear() == ano && hoje.getMonth() == mes-1 && hoje.getDate() == dia ? 'slds-is-today' : '')));
        
        evento.setParams({
            data: {
                dia,
                mes,
                ano
            }
        });
        evento.fire();
    },
    clearSelect : function(component,event,helper){
        var elements = document.getElementsByClassName('selecionado');
        var elements2 = document.getElementsByClassName('selecionado2');
        var elements3 = document.getElementsByClassName('selecionado3');
        if(elements.length > 0){
            for(var i = 0; i < elements.length;i++){
                elements[i].classList.remove('selecionado');
            }
        }
        if(elements2.length > 0){
            for(var i = 0; i < elements2.length;i++){
                elements2[i].classList.remove('selecionado2');
            }
        }
        if(elements3.length > 0){
            for(var i = 0; i < elements3.length;i++){
                elements3[i].classList.remove('selecionado3');
            }
        }
    },
    addMonths : function(date, months) {
        var d = date.getDate();
        date.setMonth(date.getMonth() + +months);
        if (date.getDate() != d) {
          date.setDate(0);
        }
        return date;
    }
})