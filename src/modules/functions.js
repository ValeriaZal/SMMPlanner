function find(model, criteria)
{
	for(var i = 0; i < model.count; ++i)
	{
		if (criteria(model.get(i)))
		{
			return model.get(i)
		}
	}
	return -1
}

function updateWindow(template_name) {
	var res_get_template = db_manager.get_template(template_name)
	console.log("||| db_manager.get_template:", res_get_template)
	namePostTextEdit.text = res_get_template[0]
	templateColorButtonBackground.color = res_get_template[1]
	textArea.text = res_get_template[3]

	var template_tags = res_get_template[4]
	console.log("template_tags:", template_tags)
	for (var i = 0; i < template_tags.length; ++i) {
		var tmp_idx = find(tagsListModel, function(ListElement) { return ListElement.tag === template_tags[i].toString() })
		tagsListModel.get(tmp_idx).checked = true
	}
}
