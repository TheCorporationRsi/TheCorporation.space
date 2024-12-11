from .. import api_v0 as api
import os
import logging
from flask import send_from_directory, jsonify



@api.route("/influence_presentation.mp4", methods=["GET"])
def influence_system_video():
    try:
        directory = os.path.join(os.path.dirname(__file__), '../../../../static')
        file_path = os.path.join(directory, "influence_presentation.mp4")

        if not os.path.exists(file_path):

            return jsonify({"error": "File not found"}), 404

        return send_from_directory(directory, "influence_presentation.mp4", as_attachment=True)
    except Exception as e:
        return jsonify({"error": str(e)}), 500
