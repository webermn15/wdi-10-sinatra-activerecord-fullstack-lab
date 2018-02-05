// console.log('linky');
// $('body').append('<p>sup fam the static js is working</p>')

const deleteItem = (itemId) => {
	// console.log("delete this fam: "+ itemId)

	$.ajax({
		url: '/items/j/'+itemId,
		method: 'DELETE',
		dataType: 'JSON',
		success: getItems,
		fail: (err) => {
			console.error('it did not delete for some reason: ' + err);
		}
	})
}

const updateItem = (itemId) => {
	// console.log('update item number '+ itemId +' forthcoming');

	const title = $('#update-item').val();

	$.ajax({
		url: '/items/j/'+itemId,
		method: 'PATCH',
		dataType: 'JSON',
		data: {
			title: title
		},
		success: getItems,
		fail: (err) => {
			console.error('was not able to patch?? help: '+ err)
		}
	})
}

// this will show a pre-populated input where the user will update the data and press a button that will send a patch request to perform the update in the database
const showEditor = (data) => {
	console.log(data);
	const $items = $('#items li');
	// console.log($items);
	let which; //this will hold the li index of the item we are trying to edit
	for (let i of $items) {
		// console.log(i)
		// console.log($(i).data('thisitem'));
			let thisIndex = $(i).data('thisitem');
			if (thisIndex == data.item.id) {
				which = i
				break;
			}
	}

	console.log(which);
	const $theItem = $(which);
	const $form = $('<div>');
	const $input = $('<input id="update-item" type="text" name"title" value="'+data.item.title+'">')
	$form.append($input);
	const $button = $('<button data-action="update">').text('update this');
	$form.append($button);
	$theItem.append($form);

}

const editItem = (itemId) => {
	console.log('edit this one, fam: '+itemId);

	$.ajax({
		url: '/items/j/edit/'+itemId,
		method: 'GET',
		dataType: 'JSON',
		success: showEditor,
		fail: (err) => {
			console.error('why wont it edit? '+ err);
		}
	})
}

$('#items').on('click', 'li', (e) => {
	// console.log($(e.currentTarget).data('thisitem'));
	// console.log($(e.target).data('action'));

	const jMethod = $(e.target).data('action');
	const itemId = $(e.currentTarget).data('thisitem');

	if (jMethod == 'delete') {
		deleteItem(itemId);
	}
	else if (jMethod == 'edit') {
		editItem(itemId);
	}
	else if (jMethod == 'update') {
		updateItem(itemId);
	}

})

$('#add-item').on('click', (e) => {
	//get value of the input
	const title = $('#new-item').val();

	// on click, send a post request
	$.ajax({
		url: '/items/j',
		method: 'POST',
		dataType: 'JSON',
		data: {
			title: title
		},
		success: (data) => {
			getItems();
			$('#new-item').val('');
		},
		fail: (err) => {
			console.error('could not post :::!::: ', err);
		}
	})

})

const getItems = () => {
	//get new list
	$.ajax({
		url: '/items/j',
		method: 'GET',
		dataType: 'JSON',
		success: printResults,
		fail: (err) => {
			console.error('theres an error', err)
		}
	})
}

const printResults = (data) => {
	// remove old list
	$('#items').empty();
	const theItems = data.items;
	// for (let i = 0; i < data.items.length; i++) {
	// 	//code
	// }
	data.items.forEach((item) => {
		const $item = $('<li data-thisitem="'+item.id+'"">')
		$item.text(item.title)
		$item.append($('<button data-action="delete">delete</button>'))
		$item.append($('<a href="#" data-action="edit">edit</a>'))
		$item.appendTo('#items')
	})
}

getItems();

