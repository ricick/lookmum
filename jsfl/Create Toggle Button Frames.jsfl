fl.getDocumentDOM().getTimeline().setSelectedFrames(0,8);
fl.getDocumentDOM().getTimeline().convertToKeyframes();
fl.getDocumentDOM().getTimeline().layers[0].frames[0].name = 'rollOut'
fl.getDocumentDOM().getTimeline().layers[0].frames[1].name = 'rollOver';
fl.getDocumentDOM().getTimeline().layers[0].frames[2].name = 'press';
fl.getDocumentDOM().getTimeline().layers[0].frames[3].name = 'disable';
fl.getDocumentDOM().getTimeline().layers[0].frames[4].name = 'rollOutToggle'
fl.getDocumentDOM().getTimeline().layers[0].frames[5].name = 'rollOverToggle';
fl.getDocumentDOM().getTimeline().layers[0].frames[6].name = 'pressToggle';
fl.getDocumentDOM().getTimeline().layers[0].frames[7].name = 'disableToggle';