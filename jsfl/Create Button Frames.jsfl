fl.getDocumentDOM().getTimeline().setSelectedFrames(0,4);
fl.getDocumentDOM().getTimeline().convertToKeyframes();
fl.getDocumentDOM().getTimeline().layers[0].frames[0].name = 'rollOut'
fl.getDocumentDOM().getTimeline().layers[0].frames[1].name = 'rollOver';
fl.getDocumentDOM().getTimeline().layers[0].frames[2].name = 'press';
fl.getDocumentDOM().getTimeline().layers[0].frames[3].name = 'disable';