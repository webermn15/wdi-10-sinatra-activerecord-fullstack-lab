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
			console.error('it did not delete for some reason: ' + err)
		}
	})
}

const editItem = (itemId) => {

	console.log('edit this one, fam: '+itemId)
}

$('#items').on('click', 'li', (e) => {
	// console.log($(e.currentTarget).data('thisitem'));
	// console.log($(e.target).data('action'));

	const jMethod = $(e.target).data('action');
	const itemId = $(e.currentTarget).data('thisitem');

	if (jMethod == 'delete') {
		deleteItem(itemId);
	}
	if (jMethod == 'edit') {
		editItem(itemId);
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

