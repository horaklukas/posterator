import {createStructuredSelector} from 'reselect';
import {NAME} from './postersConstants';

const posters = (state) => state[NAME];

export const selector = createStructuredSelector({
  posters
});

export const selectedPoster = (state) => {
	const postersState = state[NAME];
	
	return postersState.posters && postersState.selectedPosterId 
		? postersState.posters[postersState.selectedPosterId] 
		: null;
}

export const selectedPosterId = (state) => state[NAME].selectedPosterId;