import Picker from 'react-color-picker';

export const ColorPicker = () => {
  return (
    <div>
      <span className="label">{this.props.label}</span>
      <Picker value={this.props.color} onDrag={this.props.onChange} />
    </div>
  );  
}