var count_table = 1;

function refresh()
{
    count_table = 1;
}

function sayp() {
    var mydata = JSON.parse(data);

    var OptionSt = "";
    countPos = Reflect.ownKeys(mydata).length;
    for(i = 0; i < countPos;i++)
    {
        OptionSt += '<option value='+(i + 1)+'>'+mydata[String(i + 1)]+'</option>';
    }

    var elem = document.getElementById("tr"+count_table);

    var new_elem = document.createElement('tr');
    new_elem.id = "tr"+(++count_table);
    new_elem.innerHTML = '<td><input name="fn'+count_table+'" type="text"/></td><td><input name="ln'+count_table+'" type="text"/></td><td><select name="s'+count_table+'">'+OptionSt+'</select></td><td><input name="cb'+count_table+'" type="checkbox"/></td>';
    
    elem.parentNode.appendChild(new_elem);
    document.cookie="count_table="+count_table;
}

function saym() {
    if(count_table == 1)return;
    var elem = document.getElementById("tr"+count_table);
    elem.parentNode.removeChild(elem);
    count_table--;
    document.cookie="count_table="+count_table;
}

